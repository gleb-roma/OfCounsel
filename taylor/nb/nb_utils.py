def include_src():
    """
    Include the 'src' directory in the Python path.
    """
    import sys
    import os.path as op
    sys.path.insert(0, op.abspath(op.join(op.dirname(__file__), '..', 'src')))