import React from 'react'
import NavBar from './navBar'


interface LayoutProps {
    children: React.ReactNode;
  }

function Layout({children} : LayoutProps) {
  return (
    <div className='layout'>
        <NavBar />
        {children}
    </div>
  )
}

export default Layout