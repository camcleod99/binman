# Binman

Binman is a web application that runs via Docker. It updates every day at 06:00 local time by taking a snapshot of East Dumbartonshire's Bin Schedule and displaying it via a website (available at `localhost:9080`).

## Dependencies

- Docker

## Information Required

- URL to bin schedules
- - Visit https://www.eastdunbarton.gov.uk/services/a-z-of-services/bins-waste-and-recycling/bins-and-recycling/ and use the search bar to get the url of your local bin collections
- - Please copy the entire URL, if you do no the chart will not render
- - Save a .env file in the folder with the following information 
```
BINMAN_URL="https://www.example.com"
```

## Setup

### 1. Clone the repository

```bash
git clone [repository-url]
```

### 2. Make sure `bin_schedule` is executable

```bash
cd binman
chmod +x bin_schedule
```

### 3. Set up your crontab

Add the following line to your crontab:

```bash
0 6 * * * [absolute path to bin_schedule]
```

This will run the `bin_schedule` script every day at 06:00 local time.

### 4. Build the Docker image

Change directory into the `binman` folder:

```bash
cd binman
```

Then build the Docker image:

```bash
docker build -t binman .
```

### 5. Run the Docker container

```bash
docker run -d --restart unless-stopped -p 9080:80 --name binman binman
```

## Run

To run Binman manually, you can either:

- Run the `bin_schedule` script manually, **or**
- Rebuild and restart the Docker container with the following steps:

```bash
cd [path to binman]
docker build -t binman .
docker stop binman || true
docker rm binman || true
docker run -d --restart unless-stopped -p 9080:80 --name binman binman
```

## View Website

- The website can be viewed locally at:

  [http://localhost:9080](http://localhost:9080)

- If you are accessing it from another device (for example, on a home server), replace `localhost` with the server's IP address.

  Example:

  [http://192.168.1.100:9080](http://192.168.1.100:9080)