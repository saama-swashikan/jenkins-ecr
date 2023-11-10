 aws ecr describe-images --repository-name swashikan --region us-east-1  > new.txt
word=new
 cat new.txt
if grep -wq $word new.txt; then 
    echo "Exists" 
else 
    echo "Does not exist"
fi
