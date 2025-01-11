import React  from "react";
import logo from "../images/logo.gif"
function Header(){
	return (
		<header className="bg-white shadow">
			<div className="container mx-auto flex justify-between items-center py-4">
				<div className="flex items-center">
					<img alt="Company Logo" className="h-16" src={logo}/>
					<div className="ml-4">
						<h1 className="text-xl font-bold text-red-600">
							BẢO HỘ LAO ĐỘNG MINH XUÂN
						</h1>
						<p className="text-sm">
							Luôn đem lại an toàn và hoàn hảo nhất cho bạn!
						</p>
					</div>
				</div>
				<div className="text-sm">
					<p>
						Phone: 043.987.5343 - 0912.423.062 - 0912.201.309
					</p>
					<p>
						Fax: 043.987.8692
					</p>
					<p>
						Email: minhxuanbhld@gmail.com
					</p>
				</div>
			</div>
		</header>
	)
}

export default Header;
