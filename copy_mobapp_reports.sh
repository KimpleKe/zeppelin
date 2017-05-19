set -x
set -e

source_path=s3://rea-cd-omniture-reports/clean
target_path=s3://rea-consumer-data-qa/${IDP_USER}/seg-training

aws s3 rm --recursive ${target_path}
for i in {1..90}; do
  this_day=$(date --date=-${i}days "+%Y%m%d")
  aws s3 cp ${source_path}/mobappbasic/mobappbasic_${this_day}.csv.gz ${target_path}/mobappbasic/
  aws s3 cp ${source_path}/mobappproperty/mobappproperty_${this_day}.csv.gz ${target_path}/mobappproperty/
  aws s3 cp ${source_path}/mobapp_search_order/mobapp_search_order_${this_day}.csv.gz ${target_path}/mobapp_search_order/
  aws s3 cp ${source_path}/mobapp_search_refine/mobapp_search_refine_${this_day}.csv.gz ${target_path}/mobapp_search_refine/
done

exit 0
