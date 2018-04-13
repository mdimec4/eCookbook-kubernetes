# eCookbook-kubernetes
k8s templates for eCookbook

# Postgres persistent volume

 helm install --name ecookbook-vss-psql --set postgresUser=chef,postgresPassword=chef,postgresDatabase=cookbook stable/postgresql

 You shuld get output similar to this:
 
> NOTES:
PostgreSQL can be accessed via port 5432 on the following DNS name from within your cluster:
ecookbook-vss-psql-postgresql.default.svc.cluster.local

To get your user password run:

    PGPASSWORD=$(kubectl get secret --namespace default ecookbook-vss-psql-postgresql -o jsonpath="{.data.postgres-password}" | base64 --decode; echo)

To connect to your database run the following command (using the env variable from above):

   kubectl run --namespace default ecookbook-vss-psql-postgresql-client --restart=Never --rm --tty -i --image postgres \
   --env "PGPASSWORD=$PGPASSWORD" \
   --command -- psql -U chef \
   -h ecookbook-vss-psql-postgresql cookbook



To connect to your database directly from outside the K8s cluster:
     PGHOST=127.0.0.1
     PGPORT=5432

     # Execute the following commands to route the connection:
     export POD_NAME=$(kubectl get pods --namespace default -l "app=ecookbook-vss-psql-postgresql" -o jsonpath="{.items[0].metadata.name}")
     kubectl port-forward --namespace default $POD_NAME 5432:5432

# allrecipes-parser service

 kubectl create -f allrecipes_parser.yml 
