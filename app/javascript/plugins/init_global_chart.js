import { Chart, registerables } from 'chart.js';

const initGlobalChart = () => {
    const ctx = document.getElementById('myGlobalChart');
    if (!ctx)
    return
    const artists_ids = JSON.parse(ctx.dataset.artists);
    let artist_datasets = []
    artists_ids.forEach((artist_id) => { 
       one_artist_stat(artist_id).then((json_stat) => {
          let dataset = build_dataset(json_stat)
          
          artist_datasets.push(dataset);
      });
    })
    
    const data = { 
        datasets: artist_datasets
      };
    const config = {
        type: 'line',
        data,
        options: {}
      };
    
      Chart.register(...registerables);
      const myChart = new Chart(
        ctx,
        config
      );
  

}


const build_dataset = (json_stat) => {
   
    return {
        label: json_stat["name"],
        backgroundColor: 'rgb(255, 99, 132)',
        borderColor: 'rgb(255, 99, 132)',
        data: json_stat["stats"],
        // data:  [{x:'2016-12-25', y:20}, {x:'2016-12-26', y:10}],
      }
}

const one_artist_stat = (artist_id)  => {
    return fetch(`/artists/${artist_id}/statartist`, { headers: { accept: "application/json" } })
    .then(response => response.json())
    .then((data) => { 
        
        return data;
    });
    
}

export {initGlobalChart}