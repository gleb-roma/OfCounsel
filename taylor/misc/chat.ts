
const RAG_SERVER_URL = 'https://ladybird-winning-shiner.ngrok-free.app';
const AUTH_TOKEN = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiaWF0IjoxNTE2MjM5MDIyfQ.TzOHUu0Xi4oMx6F1SBGYwqqH_a2i9x7NJcD0mA-ucR0';

async function chat(query: string, params: Record<string, unknown> = {}): Promise<unknown> {
  const url = `${RAG_SERVER_URL}/chat/`;
  const headers = { Authorization: `Bearer ${AUTH_TOKEN}` };
  const response = await axios.get(url, { params: { query, params: JSON.stringify(params) }, headers });
  if (response.status === 200) {
    const results = response.data;
    return results;
  } else {
    throw new Error(`Error ${response.status} calling ${url}: ${response.statusText}`);
  }
}
