define hierarchy ZC_REF_MASTER_HIERARCHY
  as parent child hierarchy(
    source ZC_RM_PARENT_CHILD
    child to parent association _parent
    start where
      Parent_Object_Id is initial
    siblings order by
      Object_Id ascending
    multiple parents allowed
  )
{
  Object_Id,
  Parent_Object_Id,
  $node.node_id as  Node,
  $node.parent_id as Parent,
  $node.hierarchy_level as Hier_Level,
  $node.hierarchy_is_orphan as Is_Orphan,
  $node.hierarchy_is_cycle as Is_Cycle,
  $node.hierarchy_parent_rank as Parent_Rank,
  $node.hierarchy_rank as Object_Rank,
  $node.hierarchy_tree_size as Tree_Size
}
