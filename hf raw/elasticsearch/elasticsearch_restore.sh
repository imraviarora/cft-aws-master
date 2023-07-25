#!/bin/sh

echo "Clearing current data"
curl -X DELETE 'http://IP:9200/_all'

tar -xvzf /home/ubuntu/test_elasticsearch_back_up_20_02_2023.tar.gz

cd /home/ubuntu/back_up/

echo "Starting data restore"

elasticdump --input=/home/ubuntu/back_up/geo_mapping.json --output=http://IP:9200/geo --type=mapping
elasticdump --input=/home/ubuntu/back_up/geo_data.json --output=http://IP:9200/geo --type=data

elasticdump --input=/home/ubuntu/back_up/questions_mapping.json --output=http://IP:9200/questions --type=mapping
elasticdump --input=/home/ubuntu/back_up/questions_data.json --output=http://IP:9200/questions --type=data

elasticdump --input=/home/ubuntu/back_up/qa_tagging_mapping.json --output=http://IP:9200/qa_tagging --type=mapping
elasticdump --input=/home/ubuntu/back_up/qa_tagging_data.json --output=http://IP:9200/qa_tagging --type=data

echo "Data restore complete"

cd /home/ubuntu/

echo "Cleaning up back_up temporary directory"
rm -rf /home/ubuntu/back_up

echo "Final indices output"
curl -X GET http://IP:9200/_cat/indices/

echo "Restore process complete"

exit