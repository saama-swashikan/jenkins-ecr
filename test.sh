 aws ecr describe-images --repository-name swashikan   > new.txt
 cat new.txt
if grep -wq "new" new.txt; then 
    echo "Exists" 
else 
    echo "Does not exist"
fi
