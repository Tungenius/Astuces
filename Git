### Step 1: Create a new tag on the same commit point of old tag and push it, 
git tag new_tag old_tag 
git push --tags 

### Step 2: Delete the old tag from local repo. 
git tag -d old_tag 

### Step 3: Delete the old tag from remote repo. 
git push origin :refs/tags/old_tag 

### You can verify the changes made, by executing the below command. It shows all remote tags: 
git ls-remote --tags origin
