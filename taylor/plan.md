thinking out:

- new legislation comes out
- we want to see what new requirements it has on our client
    - our client is a company that makes a vr game played by children and adults
- **scan the new legislation for new requirements it might have for businesses** that make games for children and adults
    - **mark the sections of legislation**
    - **summarize the requirements from each section**
    - high-level summary of all the new requirements
- identify documents that will need to be updated (privacy policy)
- **import documents (privacy policy)**
- **scan the privacy policy**
    - **identify existing policy sections potentially related to each new requirement**
        - (could generate potential requirements for policy sections, then similarity search those and actual legal requirements)
    - **for each section related to a requirement, directly compare the policy section with the statute section and evaluate compliance**
        - **if compliant, remove statute requirement**
- **check fulfilled requirements**
- notify all unfulfilled requirements
- **suggest changes**
    - **for each unfulfilled requirement, make the minimum change to the document while fulfilling the requirement**
        - identify any external information needed to fulfill requirement, and request it
        - **identify the relevant section to edit, or create a new section**
            - (can re-use similarity search approach from earlier)
        - **propose an edit to the section that fulfills the requirement**
        - **compare the edit to the law directly**
            - (reuse from above)
            - if compliant, remove requirement. else, try again n times
    - **return edits and any outstanding unfulfilled requirements**
