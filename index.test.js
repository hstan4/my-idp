const request = require('supertest');
const app = require('./index');
describe('API', () => {
  it('returns 200 on /health', async () => {
    const res = await request(app).get('/health');
    expect(res.status).toBe(200);
    expect(res.body.status).toBe('ok');
  });
});