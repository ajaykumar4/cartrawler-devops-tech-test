/**
 * Sends a notification to Slack.
 *
 * @param message The message to send.
 * @return void
 */
def call(String slack_credentials_id, String message, String channel) {
    slackSend(channel: channel, message: message, webhookUrl: credentials(slack_credentials_id))
}