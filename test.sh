aws ecr describe-images --repository-name swashikan --region us-east-1 | grep  'IMAGETAGS' > new.txt
if grep -wq "new234" new.txt; then 
    echo "Exists" 
else 
    echo "Does not exist"
fi
