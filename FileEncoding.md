# File Encoding

##  Stat File Encoding

```bash
# Count encoding
$ find . -name "*.*" -type f -exec  file -i {} \;  | awk -F':' '{print $2}' |  awk -F';' '{print $2}' | sort -n | uniq -c
# Count encoding by file type
$ find . -name "*.*" -type f -exec  file -i {} \;  | awk -F':' '{print $2}' | sort -n | uniq -c
```


```bash
# File Liste 
$ find . -iname "*.*"  -type f -exec  file -i {} \; | grep -v 'utf-8' | grep -v 'us-ascii' | grep -v 'binary'
# File Liste 
$ find . -iname "*.*"  -type f -exec  file -i {} \; | grep -v 'utf-8' | grep -v 'us-ascii' | grep -v 'binary' | grep -v 'unknown-8bit'
# File list with excluding folder
$ find . -exec file -i {} \; -type f -name '*.php' | egrep -v "^(./tcpdf/|./scripts/|./captcha|.*map)" | grep "iso-8859-1"
```


##  Change File Encoding
```bash
$ find . -name "*.php" -type f -exec  file -i {} \; | grep iso | cut -d \: -f 1
$ find . -name "*.php" -type f -exec  file -i {} \; | grep iso | awk -F':' '{print $1}'
``` 


## Convert Encodings
```bash
$ find . -regextype posix-egrep -regex ".*\.(html|htm|phtml|css|js|php|txt|md)$"  -type f -exec  file -i {} \; | grep 'iso-8859-1'| awk -F':' '{ system("recode iso-8859-1...utf-8 " $1 ) }'
$ find . -regextype posix-egrep -regex ".*\.(t3s|tmpl|cache)$"  -type f -exec  file -i {} \; | grep 'iso-8859-1'| awk -F':' '{ system("recode iso-8859-1...utf-8 " $1 ) }'
```


### Not revelant :  us-ascii
```bash
$ find . -name "*.php"  -o -iname "*.html" -o -iname "*.css" -type f -exec  file -i {} \; | grep 'us-ascii'| awk -F':' '{ system("recode us-ascii...utf-8 " $1 ) }'
```

## Mise à jour de la base des données
#### Conversion de la base vers UTF-8
```sql
ALTER DATABASE databasename CHARACTER SET utf8 COLLATE utf8_general_ci;
```
#### Génération des requetes de conversion des tables vers UTF-8
```sql
SELECT 
    CONCAT("ALTER TABLE ",TABLE_SCHEMA,".",TABLE_NAME," CHARACTER SET utf8 COLLATE utf8_general_ci;",
    "ALTER TABLE ",TABLE_SCHEMA,".",TABLE_NAME," CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;") 
    AS alter_sql
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = "databasename";
```
Exemple de résultat :
```sql
ALTER TABLE tablename CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;
 ```
