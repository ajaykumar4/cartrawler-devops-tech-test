const request = require('supertest');
const { expect } = require('chai');
const app = require('../server');

describe('API Endpoints', () => {
  describe('GET /', () => {
    it('should return the default greeting', (done) => {
      request(app)
        .get('/')
        .end((err, res) => {
          expect(res.statusCode).to.equal(200);
          expect(res.text).to.equal('Default Greeting');
          done();
        });
    });
  });

  describe('GET /config', () => {
    it('should return the configuration value', (done) => {
      request(app)
        .get('/config')
        .end((err, res) => {
          expect(res.statusCode).to.equal(200);
          expect(res.body).to.deep.equal({
            valueFromConfigMap: 'GREETING: Default Greeting',
          });
          done();
        });
    });
  });

  describe('GET /health', () => {
    it('should return a 200 status and OK', (done) => {
      request(app)
        .get('/health')
        .end((err, res) => {
          expect(res.statusCode).to.equal(200);
          expect(res.text).to.equal('OK');
          done();
        });
    });
  });
});