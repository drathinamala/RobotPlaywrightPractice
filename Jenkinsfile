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
        PYTHON_EXE = 'C:\\Users\\drath\\AppData\\Local\\Programs\\Python\\Python314\\python.exe'
    }

    stages {
        stage('Verify Environment') {
            steps {
                bat "${PYTHON_EXE} --version"
                echo "Selected Suite Profile: ${params.SUITE_PROFILE} | Parallel Workers: ${params.PARALLEL_WORKERS}"
            }
        }

        stage('Run Parallel Playwright Tests (Pabot)') {
            steps {
                bat "${PYTHON_EXE} -m pabot.pabot --testlevelsplit --processes ${params.PARALLEL_WORKERS} --argumentfile configs/${params.SUITE_PROFILE}.args"
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
