CURRENT_VERSION=$(grep Version version | awk '{print $2}')

echo "Current Version: $CURRENT_VERSION"

NEW_VERSION=$(echo $CURRENT_VERSION |
		  awk -F. -v OFS=. 'NF==1{print ++$NF};
		  NF>1{if(length($NF+1)>length($NF))$(NF-1)++;
		  $NF=sprintf("%0*d", length($NF), ($NF+1)%(10^length($NF)));
		  print}')

echo "Release Version: $NEW_VERSION"

sed -i -e "s/^Version: [0-9].[0-99].[0-9]/Version: $NEW_VERSION/" version

git add version
git commit -m "Update version to $NEW_VERSION"
git push --set-upstream origin master
