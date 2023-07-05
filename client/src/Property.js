import react from "react";

function Property({property}) {
  return(
    <article>
      <h3 mark>{property.property_street_number} {property.property_street_name}</h3>
      <p>${property.doc_amount}</p>
      <p>{property.owner}</p>
      <h4>Associated addresses:</h4>
      <p>1. {property.owner_address_1} {property.owner_address_2}</p>
      <p>{property.date_on_deed}</p>
      <a href={'https://a836-acris.nyc.gov/DS/DocumentSearch/DocumentImageView?doc_id=' + property.document_id} role="button" target="_blank">Deed</a>
    </article>
  )
}

export default Property