node {
    def mavenHome = tool name: "Maven 3.9.9"
    def imageName = "application"  // Changed name to "application"
    def dockerHubUser = "ramu7"
    def imageTag = "${dockerHubUser}/${imageName}:${BUILD_NUMBER}"

    buildName "pipe - #${BUILD_NUMBER}"
    echo "✅ Job: ${env.JOB_NAME}, Node: ${env.NODE_NAME}"

    properties([
        buildDiscarder(logRotator(numToKeepStr: '2')),
        pipelineTriggers([githubPush()])
    ])

    stage('✅ Checkout Code') {
        git branch: 'main',
            credentialsId: '9c54f3a6-d28e-4f8f-97a3-c8e939dcc8ff',
            url: 'https://github.com/ramu0709/pipeline4.git'
    }

    def branchName = env.BRANCH_NAME ?: sh(script: "git rev-parse --abbrev-ref HEAD", returnStdout: true).trim()
    echo "✅ Git Branch: ${branchName}"

    stage('✅ Build') {
        sh "${mavenHome}/bin/mvn clean package -X"  // Debug Maven build output
        sh "ls -l target/"  // List files in the target directory to verify JAR file
    }

    stage('✅ SonarQube') {
        withSonarQubeEnv('SonarQube') {
            withCredentials([string(credentialsId: 'sonarqube-token', variable: 'SONAR_TOKEN')]) {
                sh """
                    ${mavenHome}/bin/mvn sonar:sonar -Dsonar.login=${SONAR_TOKEN}
                """
            }
        }
    }

    stage('✅ Code Coverage - JaCoCo') {
        jacoco buildOverBuild: true,
            changeBuildStatus: true,
            minimumBranchCoverage: '80',
            minimumClassCoverage: '80',
            minimumMethodCoverage: '80',
            minimumLineCoverage: '80',
            minimumInstructionCoverage: '80',
            minimumComplexityCoverage: '80'
    }

    stage('✅ Upload to Nexus') {
        def repository = (branchName == "main" || branchName == "master") ? "sample-release" : "sample-snapshot"
        def version = (branchName == "main" || branchName == "master") ? "0.0.1" : "0.0.1-SNAPSHOT"

        nexusArtifactUploader artifacts: [[
            artifactId: 'application',  // Changed name to "application"
            classifier: '',
            file: 'target/application.jar',  // Ensure this path is correct
            type: 'jar'
        ]],
        credentialsId: 'nexus-credentials',
        groupId: 'Batman',
        version: version,
        repository: repository,
        nexusUrl: '172.21.40.70:8081',
        nexusVersion: 'nexus3',
        protocol: 'http'
    }

    stage('✅ Docker Build & Push to Docker Hub') {
        withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh """
                docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
                docker build -t ${imageTag} .
                docker push ${imageTag}
            """
        }
    }

    stage('✅ Run in Docker Container') {
        sh """
            docker stop ${imageName}-${BUILD_NUMBER} || true
            docker rm ${imageName}-${BUILD_NUMBER} || true
            docker run -d --name ${imageName}-${BUILD_NUMBER} -p 9073:8080 ${imageTag}
        """
    }
}
