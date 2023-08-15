Lab:

- -> Create an Amazon RDS for MySQL instance.
- -> Enable backups to your database.
- -> Enable multiple AZs fr your Amazon RDS deployment.
- -> Create a read replica for your customer.

# Practice Labs Goals

Step-by-step guided learning

- -> Launch an Amazon RDS instance.
- -> Configure a Multi-AZ deployment.
- -> Configure Amazon RDS backups.

# DYI

Build on what you have learned

- -> Create a read replica of your primart database using a db.t3.xlarge instance.

Important details:

- -> DB instance class is set to db.t2.micro to remain within AWS's free tier. The actual practice asks for a db.t3.xlarge.
- -> In order to deploy the DB and replica using the free instance, I had to set the value `storage_encrypted` to `false`, the practice uses `db.t3.xlarge` which is not free and takes longer to be provisioned/deleted.

<h3 align="left">Connect with me:</h3>
<p align="left">
<a href="https://www.linkedin.com/in/jorluis-perales-93b92096/" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="jp-93b92096" height="30" width="40" /></a>
</p>
