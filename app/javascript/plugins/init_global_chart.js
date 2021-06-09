import { Chart, registerables } from 'chart.js';

const initGlobalChart = () => {
    const ctx = document.getElementById('myGlobalChart');
    if (!ctx)
    return
    ctx.style.backgroundColor = 'rgba(255,255,255,1)';
    const data_global = JSON.parse(ctx.dataset.stats);
    
    const artists_ids = JSON.parse(ctx.dataset.artists);
    let artist_datasets = [{
          label: 'All Artists Weekly Engagements ',
          backgroundColor: 'rgb(41, 59, 95)',
          borderColor: 'rgb(41, 59, 95)',
          data: data_global,
        //   data: [{x:'2021-06-02', y:20}, {x:'2021-06-03', y:10}],
        }]
 
   
    const data = { 
        datasets: artist_datasets
      };
    const config = {
        type: 'line',
        data,
        options: {
          scales: {
            yAxes: [{
              ticks: {
                reverse: false,
                stepSize: 3
              },
            }]
          }
        }
      };
    
      Chart.register(...registerables);
      const myChart = new Chart(
        ctx,
        config
      );
      let iteration = 0;
      artists_ids.forEach((artist_id) => { 
        one_artist_stat(artist_id).then((json_stat) => {
           let dataset = build_dataset(json_stat, iteration)
           iteration ++;
           artist_datasets.push(dataset);
           myChart.update()
       });
     })
}

const random_rgba = () => {
    const o = Math.round, r = Math.random, s = 90;
    return 'rgb(' + o(r()*s) + ',' + o(r()*s) + ',' + o(r()*s) + ',' + r().toFixed(1) + ')';
}

const rgba_array = ['rgb(255, 85, 50)','rgb(28, 197, 220)','rgb(74, 169, 108)','rgb(249, 178, 8)','rgb(4, 0, 154)','rgb(187, 55, 26)','rgb(187, 55, 26)'];



const build_dataset = (json_stat, iteration) => {
    const rgb = rgba_array[iteration % rgba_array.length];
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