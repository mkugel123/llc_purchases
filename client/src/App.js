import './App.css';
import react, { useState, useEffect } from 'react';
import '@picocss/pico/css/pico.min.css'
import Property from './Property';

function App() {

  const [properties, setProperties] = useState([])
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    fetch('/properties')
    .then(r=>r.json())
    .then(data=>setProperties(data))
  },[])


  function handleClick() {
    setLoading(true);
    fetch('/refresh')
      .then((r) => r.json())
      .then((data) => {
        setProperties(data);
        setLoading(false);
      });
  }

  console.log(properties)

  const propertyCards = properties.map((property) => {
    return(
      <Property property={property}/>
    )
  })

  return (
    <div className="App">
      <button onClick={handleClick}>Refresh</button>
      {loading ? <progress></progress> : <h5>Last Refreshed {properties[0].date_on_deed}</h5>}
      {propertyCards}
    </div>
  );
}

export default App;
