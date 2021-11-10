<link rel='stylesheet' href='assets/css/main.css'/>

# Setup Student : Setting Up Personal Workspace

## Step 1 : Instructor only : Start NoIDE
Login to the node and start noide as follows
```bash
    $   nohup ~/run-noide.sh  &
```

Go to port number 3000 of the machine to verify NoIDE is running.


## Step 2 : Create a folder

--------
# Old

## STEP 1: login to the cluster
Login in to the cluster assigned to you using SSH.  Instructor will provide details.


## STEP 2:  Make a personal workspace in Linux
After you login
```bash
        $  cd    # get to home dir
        $  mkdir   MY_NAME
        $  cd    ~/MY_NAME     #   <-- this is your personal space
```


## STEP 3:  Copy labs

```bash
        $   cd ~/MY_NAME

        # instructor will provide the command
        $  cp -a ~/a/hadoop-labs  .    # don't forget the DOT at the end!
```

