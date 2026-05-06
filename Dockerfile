FROM neo4j:5.15-community-bullseye

# Disable authentication for internal VPC access
ENV NEO4J_AUTH=none

# Install Neo4j plugins
ENV NEO4J_PLUGINS='["apoc", "apoc-extended", "graph-data-science"]'

# Configure Neo4j
RUN sed -i 's/#dbms.security.procedures.allowlist=apoc.coll.*,apoc.load.*,gds.*/dbms.security.procedures.allowlist=apoc.*,gds.*/g' "${NEO4J_HOME}/conf/neo4j.conf"

# Set default database name
ENV NEO4J_DATABASE_NAME=gfedb
RUN sed -i "s/#initial.dbms.default_database=neo4j/initial.dbms.default_database=${NEO4J_DATABASE_NAME}/g" "${NEO4J_HOME}/conf/neo4j.conf"

# Expose Neo4j ports
EXPOSE 7474 7473 7687

# Use the IMGT release version as a build arg
ARG IMGT
ENV IMGT_RELEASE=${IMGT}

# The data will be loaded separately after deployment
# This Dockerfile creates a base Neo4j image ready for data loading
