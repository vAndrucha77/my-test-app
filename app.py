from flask import Flask, render_template
import random
import platform

app = Flask(__name__)

# list of cat images
images = [
    "http://i.imgur.com/Ej8Oyf8.gif",
    "http://i.imgur.com/b1NIPz5.gif",
    "http://33.media.tumblr.com/5927af2667fc508a05669869a4bc12e2/tumblr_njau87kB0I1qjsn9po1_400.gif",
    "http://25.media.tumblr.com/59e1f9be5d6daa7d571313e46ec6e5cf/tumblr_mvudvqk4KQ1smbojlo1_500.gif",
    "http://25.media.tumblr.com/3b4854331c2ecc8bc5c4adc59742ca66/tumblr_mtulnpDNun1rrav49o1_400.gif",
    "https://drive.google.com/open?id=0ByZw7yGAswlyN3B5SEp2VjU2bHM"
]

@app.route('/')
def index():
    url = random.choice(images)
    hostname = platform.node()
    return render_template('index.html', url=url, hostname=hostname)

if __name__ == "__main__":
    app.run(host="0.0.0.0")
