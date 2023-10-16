import React from 'react'
import "./page404.css"
import { useNavigate } from 'react-router'

function Page404() {

  const navigate = useNavigate()
  return (
    <div className='not-found'  >
          <div className='title'>
            4O4
          </div>
          <div className='descr'>
            this page was not found  , you maybe have mistiyped 
          </div>
          <div className='descr'>
          the address or the page may have moved
          </div>
          <div onClick={()=>navigate("/")} className='home'>
            Take me to the Home page
          </div>
    </div>

  )
}

export default Page404