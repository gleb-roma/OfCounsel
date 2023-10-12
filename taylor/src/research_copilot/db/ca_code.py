def dict_to_query_params(d):
    return "{" + ", ".join([f"{k}: ${k}" for k in d.keys()]) + "}"


# subsection_query = f"""
# WITH $subsec_ref AS idList
# MATCH p=(:NodeType {resolved_sec_ref_str})-[:PARENT_OF*..]->(endNode:NodeType {{id: idList[-1]}})
# WHERE all(i in range(1, size(idList) - 1) WHERE (nodes(p)[i]).id = idList[i])
# RETURN endNode
# """

# from research_copilot.db.graph import graph

# results = graph.query(subsection_query, params={
#   **resolved_sec_ref,
#   'subsec_ref': subsec_ref})
