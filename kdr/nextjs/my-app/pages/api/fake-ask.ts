// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import type { NextApiRequest, NextApiResponse } from 'next'
 
type ResponseData = {
  message: string
}

import axios from "axios";

async function handler(
  req: NextApiRequest,
  res: NextApiResponse<ResponseData>
) {
  const data = JSON.parse(req.body);
  console.log(data);

  res.status(200).json({message: "Hello this is default answer"});
}

export default handler
