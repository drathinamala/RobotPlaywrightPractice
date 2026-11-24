pipeline {
    agent any

    environment {
        PYTHON_EXE = 'C:\\Users\\drath\\AppData\\Local\\Programs\\Python\\Python314\\python.exe'
    }

    stages {
        stage('Verify Environment') {
            steps {
                bat "${PYTHON_EXE} --version"
            }
        }

        stage('Run Playwright Robot Tests') {
            steps {
                bat "${PYTHON_EXE} -m robot --variable HEADLESS:True --outputdir results tests/"
            }
        }
    }

    post {
        always {
            robot(
                outputPath: 'results',
                outputFileName: 'output.xml',
                logFileName: 'log.html',
                reportFileName: 'report.html',
                passThreshold: 100.0,
                unstableThreshold: 90.0
            )
        }
    }
}
