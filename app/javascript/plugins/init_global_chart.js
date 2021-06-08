import { Chart, registerables } from 'chart.js';

const initGlobalChart = () => {
    const ctx = document.getElementById('myGlobalChart');
    if (!ctx)
    return
    const data_global = JSON.parse(ctx.dataset.stats);
    console.log(data_global);
    const artists_ids = JSON.parse(ctx.dataset.artists);
    let artist_datasets = [{
          label: 'My Artist Interactions  This Week',
          backgroundColor: 'rgb(255, 99, 132)',
          borderColor: 'rgb(255, 99, 132)',
          data: data_global,
        //   data: [{x:'2021-06-02', y:20}, {x:'2021-06-03', y:10}],
        }]
    artists_ids.forEach((artist_id) => { 
       one_artist_stat(artist_id).then((json_stat) => {
          let dataset = build_dataset(json_stat)
          
          artist_datasets.push(dataset);
      });
    })
    console.log(artist_datasets);
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

const random_rgba = () => {
    const o = Math.round, r = Math.random, s = 255;
    return 'rgb(' + o(r()*s) + ',' + o(r()*s) + ',' + o(r()*s) + ',' + r().toFixed(1) + ')';
}


const build_dataset = (json_stat) => {
    const rgb = random_rgba();
    return {
        label: json_stat["name"],
        backgroundColor: rgb,
        borderColor: rgb,
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