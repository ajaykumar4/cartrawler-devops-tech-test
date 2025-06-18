const express = require('express');

const app = express();

// Read configuration from environment variables. 
// These are populated by the Kubernetes ConfigMap and Secret specified in the deployment.
const PORT = process.env.PORT || 80;
const GREETING = process.env.GREETING || 'Default Greeting';

/**
 * The main endpoint, which displays the greeting message from the ConfigMap. 
 */
app.get('/', (req, res) => {
  res.send(GREETING);
});

/**
 * An endpoint to display the configuration values loaded from the
 * ConfigMap and Secret.
 *
 * WARNING: Displaying secrets is insecure and is done here for
 * demonstration purposes only.
 */
app.get('/config', (req, res) => {
  // WARNING: Displaying secrets is insecure. This is for demonstration only.
  res.status(200).json({
    "valueFromConfigMap": `GREETING: ${GREETING}`
  });
});

/**
 * A simple health check endpoint.
 */
app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});