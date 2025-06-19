/**
 * Executes npm test on the Node.js application.
 *
 * This function installs the necessary dependencies using npm ci and then runs the tests defined in the package.json file.
 *
 * @return void
 */
def call() {
    sh """
        npm ci
        npm test
    """
}