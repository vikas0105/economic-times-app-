<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Economic Times Lite</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">
<div class="container mt-4">
    <h2 class="text-center mb-4">Economic Times – Top Business News</h2>

    <div id="newsContainer" class="row"></div>
</div>

<script>
    fetch("news")
        .then(response => response.json())
        .then(data => {
            const container = document.getElementById("newsContainer");

            if (!data.articles) {
                container.innerHTML = "<p class='text-danger'>Unable to load news</p>";
                return;
            }

            data.articles.forEach(article => {
                const card = `
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <img src="${article.image}" class="card-img-top">
                            <div class="card-body">
                                <h5 class="card-title">${article.title}</h5>
                                <p>${article.description}</p>
                                <a href="${article.url}" target="_blank" class="btn btn-primary btn-sm">
                                    Read More
                                </a>
                            </div>
                        </div>
                    </div>
                `;
                container.innerHTML += card;
            });
        });
</script>

</body>
</html>
