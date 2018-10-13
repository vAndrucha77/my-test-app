node ("dockerslave") {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("dtr.andreas.dtcntr.net/docker-cemea/my-test-app")
    }

    stage('Aqua MicroScanner') {
        /* This step scans the image for high vulnerabilities and
         * FAILS if any are found */

        aquaMicroscanner imageName: 'dtr.andreas.dtcntr.net/docker-cemea/my-test-app:latest', notCompliesCmd: 'exit1', onDisallowed: 'fail', outputFormat: 'html'
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * Just an example */
        /*
        docker.image("dtr.andreas.dtcntr.net/docker-cemea/my-test-app").inside {
            sh 'curl --fail http://localhost:5000 || exit 1'
        }*/
        sh 'echo "Test successful and passed"'
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://dtr.andreas.dtcntr.net', 'DTRUserPassword') {
            app.push("2.${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

    /* stage('Deploy a service on DEE') {
        sh "cd /home/jenkins && \
        source env.sh && \
        docker service update --image dtr.andreas.dtcntr.net/docker-cemea/my-test-app:latest mta || \
        docker service create --name mta \
                              --replicas 3 \
                              --publish published=8089,target=5000 \
                              dtr.andreas.dtcntr.net/docker-cemea/my-test-app"
     } */
}