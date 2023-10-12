// Change all these values for the demo

export const docTitle = "Rec Room Policy";

export const originalDocText = `Rec Room Inc., a Delaware corporation (“Company”, “we”, “us”, “our”), may collect and use the below categories of your Personal Information. Third parties such as Greenhouse also may collect such Personal Information on our behalf. “Personal Information” means information that identifies, relates to, describes, is reasonably capable of being associated with, or could reasonably be linked, directly or indirectly, with you.

Full name
Home address
Telephone number
Email address
Resume information
Interview feedback
Compensation expectations
Authorization to work in the United States and/or visa requirements, if applicable

The Company collects the above categories of Personal Information to use or disclose as appropriate to:
Recruit and evaluate job applicants for employment
Comply with all applicable laws and regulations
Perform data analytics
Exercise or defend the legal rights of the Company

If you have any questions about this Notice or need to access this Notice in an alternative format due to having a disability, please contact us at hr@recroom.com and privacy@recroom.com. `;

export const newDocText = `Rec Room Inc., a Delaware corporation ("Company", "we", "us", "our"), may collect and use the below categories of your Personal Information and Sensitive Personal Information. Third parties such as Greenhouse also may collect such Personal Information on our behalf. "Personal Information" means information that identifies, relates to, describes, is reasonably capable of being associated with, or could reasonably be linked, directly or indirectly, with you. Sensitive Personal Information includes [list of sensitive personal information].

Full name
Home address
Telephone number
Email address
Resume information
Interview feedback
Compensation expectations
Authorization to work in the United States and/or visa requirements, if applicable

The Company collects the above categories of Personal Information and Sensitive Personal Information to use or disclose as appropriate to:
Recruit and evaluate job applicants for employment
Comply with all applicable laws and regulations
Perform data analytics
Exercise or defend the legal rights of the Company

The Company does not sell your Personal Information or Sensitive Personal Information. The Company may share your Personal Information or Sensitive Personal Information with [list of entities or types of entities with whom information is shared].

The Company intends to retain each category of Personal Information and Sensitive Personal Information for [length of time] or until [criteria for retention]. The Company will not retain your Personal Information or Sensitive Personal Information for longer than is reasonably necessary for the disclosed purpose.

If you have any questions about this Notice or need to access this Notice in an alternative format due to having a disability, please contact us at hr@recroom.com and privacy@recroom.com.
`;


export const summaryOfChanges = `The current policy of Rec Room Inc. does not comply with the new law in the following ways:

1. The policy does not specify whether the collected personal information is sold or shared, which is required by the new law.
2. The policy does not distinguish between personal information and sensitive personal information, nor does it provide the categories of sensitive personal information to be collected and the purposes for which they are collected or used.
3. The policy does not provide the length of time the business intends to retain each category of personal information, including sensitive personal information, or the criteria used to determine that period.
`;

// Generate via something like https://github.com/ofcounselAi/launchable/blob/dev/kdr/notebooks/representing-doc-diffs.ipynb
export const docDiff = {__html: `Rec Room Inc., a Delaware corporation (<span class="del">“</span><span class="ins">"</span>Company<span class="del">”</span><span class="ins">"</span>, <span class="del">“</span><span class="ins">"</span>we<span class="del">”</span><span class="ins">"</span>, <span class="del">“us”</span><span class="ins">"us"</span>, <span class="del">“our”</span><span class="ins">"our"</span>), may collect and use the below categories of your Personal Information<span class="ins"> and Sensitive Personal Information</span>. Third parties such as Greenhouse also may collect such Personal Information on our behalf. <span class="del">“</span><span class="ins">"</span>Personal Information<span class="del">”</span><span class="ins">"</span> means information that identifies, relates to, describes, is reasonably capable of being associated with, or could reasonably be linked, directly or indirectly, with you.<span class="ins"> Sensitive Personal Information includes [list of sensitive personal information].</span><br /><br />Full name<br />Home address<br />Telephone number<br />Email address<br />Resume information<br />Interview feedback<br />Compensation expectations<br />Authorization to work in the United States and/or visa requirements, if applicable<br /><br />The Company collects the above categories of<span class="ins"> Personal Information and Sensitive</span> Personal Information to use or disclose as appropriate to:<br />Recruit and evaluate job applicants for employment<br />Comply with all applicable laws and regulations<br />Perform data analytics<br />Exercise or defend the legal rights of the Company<br /><br /><span class="ins">The Company does not sell your Personal </span>I<span class="del">f you ha</span><span class="ins">nformation or Sensiti</span>ve <span class="ins">Personal Information. The Company may share your Personal Information or Sensitive Personal Information with [list of entities or types of entities with whom information is shared].<br /><br />The Company intends to retain each category of Personal Information and Sensitive Personal Information for [length of time] or until [criteria for retention]. The Company will not retain your Personal Information or Sensitive Personal Information for longer than is reasonably necessary for the disclosed purpose.<br /><br />If you have </span>any questions about this Notice or need to access this Notice in an alternative format due to having a disability, please contact us at hr@recroom.com and privacy@recroom.com.<span class="del"> <br /></span><span class="ins"><br /></span>`};