# aws ecr describe-images --repository-name swashikan --region us-east-1  > new.txt
# cat new.txt
if grep -wq "new" new.txt; then 
    echo "Exists" 
else 
    echo "Does not exist"
fi
