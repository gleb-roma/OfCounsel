// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import type { NextApiRequest, NextApiResponse } from 'next'
 
type ResponseData = {
  message: string
}

import axios from "axios";

const RAG_SERVER_URL = 'https://ladybird-winning-shiner.ngrok-free.app/chat/';
const AUTH_TOKEN = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiaWF0IjoxNTE2MjM5MDIyfQ.TzOHUu0Xi4oMx6F1SBGYwqqH_a2i9x7NJcD0mA-ucR0';

async function handler(
  req: NextApiRequest,
  res: NextApiResponse<ResponseData>
) {
  const data = JSON.parse(req.body);
  console.log(data);

  const headers = {    
    Authorization: `Bearer ${AUTH_TOKEN}`,
  };

  const config = {
    headers: headers,
    params: {
      query: data.ask,//'What are the General Duties of Businesses that Collect Personal Information?'
    }
  }

  const response = await axios.get(RAG_SERVER_URL, config);
  console.log('the repsonse: ====== ' )
  console.log(response);

  res.status(response. status).json({message: response.data});
}

export default handler
