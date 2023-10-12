check_if_req = """\
Does the following subsection of a statute require an update to a business's privacy policy?

Some context from parent sections of the subsection:
```
{parent_context}
```

And the subsection itself:
```
{subsection_text}
```

Return only YES or NO
"""

summarize_req = """\
Please summarize the requirements of a business's privacy policy that are  enforced by the following subsection of a statute.

Some context from parent sections of the subsection:
```
{parent_context}
```

And the subsection itself:
```
{subsection_text}
```
"""

hypothetical_req = """\
Please write some hypothetical legal requirements that would have required the following sections of a business's privacy policy to be written. Each requirement should be different in meaning from the others and present only if necessary. Include a maximum of 3 requirements.

```
{policy_section_text}
```

Return the hypothetical subsections as a JSON list of strings.
"""

check_req_fulfilled = """\
Does the following section from a privacy policy properly fulfill the requirements from the provided subsection of a statute?

The privacy policy section:
```
{policy_section_text}
```

The statute subsection, including context from parent sections:
```
{path_text}
```

Return only YES or NO
"""
