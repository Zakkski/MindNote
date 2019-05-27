import "bootstrap";


const resultList = document.querySelector('#song-search-results')

const searchBox = document.querySelector("#song-search");

const baseUrl = "https://itunes.apple.com/search?term="


const outputToScreen = (songs) => {
  resultList.innerHTML = "";
  if (songs) {
    songs.forEach((song) => {
      resultList.insertAdjacentHTML('beforeend',
        `<form action="/songs" method='post'>
        <input type="hidden" name="album_url" value='${song['collectionViewUrl']}'>
        <input type="text" name="title" value='${song['trackName']}'>
        <input type="text" name="artist" value='${song['artistName']}'>
        <input type="submit">`
        )
    })
  }
}


searchBox.addEventListener('submit', (event) => {
  event.preventDefault();
  const searchTerm= event.currentTarget.querySelector('.query');

  fetch(baseUrl+searchTerm.value+"&entity=musicTrack&limit=5")
  .then(response => response.json())
  .then((data)=> {
    console.log(data);
    outputToScreen(data.results);
  });
});
