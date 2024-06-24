
> pRoonm is a lightweight form brute-forcing tool that can break any form that contains a username and a password fields.

At this time, pRoonm is still at early stage development, functionalities are very limited but they are good enough for classical web forms.

## Installation
```
git clone https://github.com/rahul-joy/pRoonm.git
```
```
cd pRoonm
```
```
chmod +x pRoonm.sh
```
```
./pRoonm.sh
```



# Usage

| Command | Action | Example
|----|----|----|
| set url \<value> | Setting the form url to a new value| set url http://www.example.com/form1.php |
| set users \<value>|  Give users list a new value | set users users_list.txt
|set passwords \<value> | Give passwords list a new value | set passwords passwords_list.txt
| set userField \<value> | Enter the value of the user field (as in the html |set userField username
| set passField \<value> | Enter the value of the password field (as in the |set userField password
|set ssMsg \<value>     | Setting the success string to test on             | set ssMsg success.txt
| start                 | Start brute-forcing                                
| help                  | Show this help message                                                           
|clear|Clear console
|exit| Exit pRoonm



## Help Improving pRoonm

 Do you have a new idea? Or you think pRoonm is missing something? Simply make a new pull request or contact me @ prof.dumbledore.ceh@gmail.com to suggest changes.

## Report A Bug
An error has occurred and you have no clue what caused it? **Don't panic,** as mentioned above pRoonm is still at early stage development, errors and bugs might occur, just make a new issue or contact me @ prof.dumbledore.ceh@gmail.com for bug report.
# Legal Disclaimer

- I do not take any responsibility and I am not liable for any damage caused through the use of this product.
- I do not take responsibility for any illegal usage.

![pRoonm MIT License](https://image.ibb.co/hWqzp9/license.png)
