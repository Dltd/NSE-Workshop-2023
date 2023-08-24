# Lab 1 - Hello World
Step 1: Inspect the Original Script
First, inspect the original NSE script. You can do this by opening the file hello-world.nse in any text editor.

Step 2: Run the Original Script with a Hostrule
Run the script using the following command:

```bash
cd ~/NSE-Workshop-2023
nmap scanme.nmap.org --script ./Examples/hello-world.nse 
```

The output should look like the following:

```
$ nmap scanme.nmap.org --script ./Examples/hello-world.nse 
Starting Nmap 7.94 ( https://nmap.org ) at 2023-08-20 13:26 EDT
Nmap scan report for scanme.nmap.org (45.33.32.156)
Host is up (0.069s latency).
Not shown: 994 closed tcp ports (conn-refused)
PORT      STATE    SERVICE
22/tcp    open     ssh
80/tcp    open     http
135/tcp   filtered msrpc
139/tcp   filtered netbios-ssn
9929/tcp  filtered nping-echo
31337/tcp open     Elite

Host script results:
| hello-world: 
|_  Hello from your NSE Script!

Nmap done: 1 IP address (1 host up) scanned in 43.54 seconds
```


 Take note of how the script behaves with a hostrule.


Step 3: Modify the Script to Use a Portrule
Open the hello-world.nse file in a text editor and look for the hostrule function. Change it to a portrule function.

Create a copy of the scrip called `hello-port.nse` and us VS Code to modify the portrule function to use the port argument.

```bash
cp Example/hello-world.nse Example/hello-port.nse
code Example/hello-port.nse
```

Find the following:

```lua
hostrule = function(host) return true end
```

Change it to:

```lua
portrule = function(host, port) return true end
```

Save the changes.

Step 4: Run the Modified Script with a Portrule
Run the modified script using the same command as before:

```bash
nmap scanme.nmap.org --script .Exampmle/hello-port.nse
```

Compare the output with the original hostrule version and observe the differences.

Conclusion
In this lab, you've learned how to run an NSE script and modify it to see the difference between a hostrule and a portrule. This exercise can help you understand how NSE scripts can be customized for different scanning scenarios.
