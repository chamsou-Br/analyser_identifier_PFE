import React, {  useState } from 'react'
import "../styles/home.css"
import { FaPaperPlane } from 'react-icons/fa'
import { useNavigate } from 'react-router'

const HomeScreen : React.FC = () => {
    const [path , setPath] = useState("")

    const navigate = useNavigate()

    const onStartAnalyzer = () => {
        navigate(`/analyze?path=${encodeURIComponent(path)}`)
    }

  return (
    <div className='home-container' >
        <div className='path-container' >
            <input value={path} onChange={(e) => setPath(e.target.value)} placeholder='Please provide the project path for analysis !' />
            <div onClick={onStartAnalyzer} className='start-button' >
                <div className="label">Start Analyzer</div>
                <FaPaperPlane size={12} className='icon' />
            </div>
        </div>
    </div>
  )
}

export default HomeScreen