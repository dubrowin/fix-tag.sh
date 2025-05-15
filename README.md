# fix-tag.sh
Bash script with AWS CLI to update 1 EC2 Tag with another

I run this inside CloudShell to avoid needing to deal with permissions and profiles

## Usage

```usage: fix-tag.sh [ -h | --help ] [ -r | --region <region: us-east-2> ] [ -o | --old-tag <Case Sensitive Tag Name> ] [ -n | --new-tag <Case Sensitive Tag Name> ]```

## Example Usage

I found that I had a Cost Allocation Tag of Project, but my instances had project set and I wanted to run it in another region

```
./fix-tags.sh -o project -n Project -r eu-west-1
Old Tag is: project
New Tag is: Project
Using --region eu-west-1
Using --region eu-west-1
Searching for instances in --region eu-west-1 with the tag project
Setting i-0c001122334455667 Project to EKS_Workshop
Removing i-0c001122334455667 project
Updated tags for instance i-0c001122334455667
```
