pipeline {
    agent any
    stages {
        stage("clone") {
            steps {
                git(url:"https://github.com/a-malex/wordpres-ci.git", credentialsId:"ahmad-github")
            }
        }
        stage("build") {
            steps {
                script {
                    myWordpressImage = docker.build("jenkins-stack-docker_registry_1/my-wordpress:latest")
                }
            }
        }
        stage("release") {
            steps {
                script {
                    docker.withRegistry("jenkins-stack-docker_registry_1", "registery-login") {
                        myWordpressImage.push()
                        gitLastCommit = sh(script: "git rev-parse HEAD", returnStdout: true).trim()
                        myWordpressImage.push(gitLastCommit)
                        gitLastTag = sh(script:"git tag --points-at HEAD", returnStdout: true).trim()
                        if (gitLastTag != "") {
                            gitLastTag = gitLastTag.minus("v")
                            majorVersion = gitLastTag.split("\\.")[0]
                            minorVersion = gitLastTag.split("\\.")[0] + "." + gitLastTag.split("\\.")[1]
                            myWordpressImage.push(majorVersion)
                            myWordpressImage.push(minorVersion)
                        }
                    }
                }
            }
        }
    }
}

