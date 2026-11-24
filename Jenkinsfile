pipeline {
    agent any

    parameters {
        choice(
            name: 'SUITE_PROFILE',
            choices: ['regression', 'smoke'],
            description: 'Select the execution profile from configs/ (regression = all 6 tests, smoke = fast E2E check)'
        )
        string(
            name: 'PARALLEL_WORKERS',
            defaultValue: '4',
            description: 'Number of parallel Pabot browser workers'
        )
    }

    environment {


            environment {
        PYTHON_DIR = 'C:\\Users\\drath\\AppData\\Local\\Programs\\Python\\Python314'
        PATH+PYTHON = "${PYTHON_DIR};${PYTHON_DIR}\\Scripts"
    }

    }

    stages {
        stage('Verify Environment') {
            steps {
                bat 'python --version'
                echo "Selected Suite Profile: ${params.SUITE_PROFILE} | Parallel Workers: ${params.PARALLEL_WORKERS}"
            }
        }

        stage('Run Parallel Playwright Tests (Pabot)') {
            steps {
                bat "pabot --testlevelsplit --processes ${params.PARALLEL_WORKERS} --argumentfile configs/${params.SUITE_PROFILE}.args tests/"
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
