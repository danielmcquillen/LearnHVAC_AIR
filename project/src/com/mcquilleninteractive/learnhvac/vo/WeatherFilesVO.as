// ActionScript file
package  com.mcquilleninteractive.learnhvac.vo 
{
	public class WeatherFilesVO
	{
		
		public var weatherFiles:XML
		
		
		public function WeatherFilesVO()
		{
			
			weatherFiles = <weatherfiles>
				<state name="-- select a state--">
					<city name="" url=""/>
				</state>
				<state name="Alaska">
					<city name="Adak NAS" url="USA_AK_Adak.NAS_TMY.epw"/>
					<city name="Anchorage" url="USA_AK_Anchorage_TMY2.epw"/>
				</state>
				<state name="Alabama">
					<city name="Birmingham" url="USA_AL_Birmingham_TMY2.epw"/>
					<city name="Mobile" url="USA_AL_Mobile_TMY2.epw"/>
				</state>
				<state name="Arkansas">
					<city name="Fort Smith" url="USA_AR_Fort.Smith_TMY2.epw"/>
					<city name="Little Rock" url="USA_AR_Little.Rock_TMY2.epw"/>
				</state>
				<state name="Arizona">
					<city name="Phoenix" url="USA_AZ_Phoenix_TMY2.epw"/>
					<city name="Tucson" url="USA_AZ_Tucson_TMY2.epw"/>
				</state>
				<state name="California">
					<city name="Los Angeles" url="USA_CA_Los.Angeles_TMY2.epw"/>
					<city name="San Francisco" url="USA_CA_San.Francisco_TMY2.epw"/>
				</state>
				<state name="Colorado">
					<city name="Boulder" url="USA_CO_Boulder_TMY2.epw"/>
					<city name="Denver-Stapleton" url="USA_CO_Denver-Stapleton_TMY.epw"/>
				</state>
				<state name="Connecticut">
					<city name="Bridgeport" url="USA_CT_Bridgeport_TMY2.epw"/>
					<city name="Hartford" url="USA_CT_Hartford_TMY2.epw"/>
				</state>
				<state name="Delaware">
					<city name="Wilmington" url="USA_DE_Wilmington_TMY2.epw"/>
				</state>
				<state name="Florida">
					<city name="Jacksonville" url="USA_FL_Jacksonville_TMY2.epw"/>
					<city name="Tampa" url="USA_FL_Tampa_TMY2.epw"/>
				</state>
				<state name="Georgia">
					<city name="Jacksonville" url="USA_GA_Atlanta_TMY2.epw"/>
					<city name="Tampa" url="USA_GA_Augusta_TMY2.epw"/>
				</state>
				<state name="Hawaii">
					<city name="Honolulu" url="USA_HI_Honolulu_TMY2.epw"/>
					<city name="Kahului" url="USA_HI_Kahului_TMY2.epw"/>
				</state>
				<state name="Iowa">
					<city name="Des Moines" url="USA_IA_Des.Moines_TMY2.epw"/>
					<city name="Sioux City" url="USA_IA_Sioux.City_TMY2.epw"/>
				</state>
				<state name="Idaho">
					<city name="Boise" url="USA_ID_Boise_TMY2.epw"/>
					<city name="Lewiston" url="USA_ID_Lewiston_TMY.epw"/>
				</state>
				<state name="Illinois">
					<city name="Chicago-Midway" url="USA_IL_Chicago-Midway_TMY.epw"/>
					<city name="Springfield" url="USA_IL_Springfield_TMY2.epw"/>
				</state>
				<state name="Indiana">
					<city name="Indianapolis" url="USA_IN_Indianapolis_TMY2.epw"/>
					<city name="Fort Wayne" url="USA_IN_Fort.Wayne_TMY2.epw"/>
				</state>
				<state name="Indiana">
					<city name="Topeka" url="USA_KS_Topeka_TMY2.epw"/>
					<city name="Wichita" url="USA_KS_Wichita_TMY2.epw"/>
				</state>
				<state name="Kentucky">
					<city name="Topeka" url="USA_KY_Lexington_TMY2.epw"/>
					<city name="Wichita" url="USA_KY_Louisville_TMY2.epw"/>
				</state>
				<state name="Louisiana">
					<city name="New Orleans" url="USA_LA_New.Orleans_TMY2.epw"/>
					<city name="Baton Rouge" url="USA_LA_Baton.Rouge_TMY2.epw"/>
				</state>
				<state name="Louisiana">
					<city name="New Orleans" url="USA_LA_New.Orleans_TMY2.epw"/>
					<city name="Baton Rouge" url="USA_LA_Baton.Rouge_TMY2.epw"/>
				</state>
				<state name="Massachusettes">
					<city name="Boston City" url="USA_MA_Boston-City.WSO_TMY.epw"/>
					<city name="Worchester" url="USA_MA_Worchester_TMY2.epw"/>
				</state>
				<state name="Maryland">
					<city name="Baltimore" url="USA_MD_Baltimore_TMY2.epw"/>
					<city name="Worchester" url="USA_MD_Patuxent.River.NAS_TMY.epw"/>
				</state>
				<state name="Maine">
					<city name="Bangor" url="USA_ME_Bangor_TMY.epw"/>
					<city name="Portland" url="USA_ME_Portland_TMY2.epw"/>
				</state>
				<state name="Michigan">
					<city name="Detroit" url="USA_MI_Detroit-Metro.AP_TMY2.epw"/>
					<city name="Grand Rapids" url="USA_MI_Grand.Rapids_TMY2.epw"/>
				</state>
				<state name="Minnesota">
					<city name="Duluth" url="USA_MN_Duluth_TMY2.epw"/>
					<city name="Minneapolis-St.Paul" url="USA_MN_Minneapolis-St.Paul_TMY2.epw"/>
				</state>
				<state name="Missouri">
					<city name="Springfield" url="USA_MO_Springfield_TMY2.epw"/>
					<city name="St. Louis" url="USA_MO_St.Louis_TMY2.epw"/>
				</state>
				<state name="Mississippi">
					<city name="Jackson" url="USA_MS_Jackson_TMY2.epw"/>
					<city name="Meridian" url="USA_MS_Meridian_TMY2.epw"/>
				</state>
				<state name="Montana">
					<city name="Great Falls" url="USA_MT_Great.Falls_TMY2.epw"/>
					<city name="Missoula" url="USA_MT_Missoula_TMY2.epw"/>
				</state>
				<state name="North Carolina">
					<city name="Asheville" url="USA_NC_Asheville_TMY2.epw"/>
					<city name="Raleigh-Durham" url="USA_NC_Raleigh-Durham_TMY2.epw"/>
				</state>
				<state name="North Dakota">
					<city name="Bismarck" url="USA_ND_Bismarck_TMY2.epw"/>
					<city name="Fargo" url="USA_ND_Fargo_TMY2.epw"/>
				</state>
				<state name="Nebraska">
					<city name="Norfolk" url="USA_NE_Norfolk_TMY2.epw"/>
					<city name="Omaha" url="USA_NE_Omaha_TMY2.epw"/>
				</state>
				<state name="New Hampshire">
					<city name="Concord" url="USA_NH_Concord_TMY2.epw"/>
				</state>
				<state name="New Jersey">
					<city name="Atlantic City" url="USA_NJ_Atlantic.City_TMY2.epw"/>
					<city name="Newark" url="USA_NJ_Newark_TMY2.epw"/>
				</state>
				<state name="New Mexico">
					<city name="Albuquerque" url="USA_NM_Albuquerque_TMY2.epw"/>
					<city name="Roswell" url="USA_NM_Roswell_TMY.epw"/>
				</state>
				<state name="Nevada">
					<city name="Las Vegas" url="USA_NV_Las.Vegas_TMY2.epw"/>
					<city name="Reno" url="USA_NV_Reno_TMY2.epw"/>
				</state>
				<state name="New York">
					<city name="New York - Central Park" url="USA_NY_New.York.City-Central.Park_TMY2.epw"/>
					<city name="Syracuse" url="USA_NY_Syracuse_TMY2.epw"/>
				</state>
				<state name="Ohio">
					<city name="Cleveland" url="USA_OH_Cleveland_TMY2.epw"/>
					<city name="Dayton" url="USA_OH_Dayton_TMY2.epw"/>
				</state>
				<state name="Oklahoma">
					<city name="Oklahoma" url="USA_OK_Oklahoma.City_TMY2.epw"/>
					<city name="Tulsa" url="USA_OK_Tulsa_TMY2.epw"/>
				</state>
				<state name="Oregon">
					<city name="Eugene" url="USA_OR_Eugene_TMY2.epw"/>
					<city name="Portland" url="USA_OR_Portland_TMY2.epw"/>
				</state>
				<state name="Pennsylvania">
					<city name="Erie" url="USA_PA_Erie_TMY2.epw"/>
					<city name="Philadelphia" url="USA_PA_Philadelphia_TMY2.epw"/>
				</state>
				<state name="Rhode Island">
					<city name="Providence" url="USA_RI_Providence_TMY2.epw"/>
				</state>
				<state name="South Carolina">
					<city name="Charleston" url="USA_SC_Charleston_TMY2.epw"/>
					<city name="Columbia" url="USA_SC_Columbia_TMY2.epw"/>
				</state>
				<state name="South Dakota">
					<city name="Rapid City" url="USA_SD_Rapid.City_TMY2.epw"/>
					<city name="Sioux Falls" url="USA_SD_Sioux.Falls_TMY2.epw"/>
				</state>
				<state name="Tennessee">
					<city name="Knoxville" url="USA_TN_Knoxville_TMY2.epw"/>
					<city name="Nashville" url="USA_TN_Nashville_TMY2.epw"/>
				</state>
				<state name="Texas">
					<city name="Austin" url="USA_TX_Austin_TMY2.epw"/>
					<city name="Fort Worth" url="USA_TX_Fort.Worth_TMY2.epw"/>
				</state>
				<state name="Utah">
					<city name="Cedar City" url="USA_UT_Cedar.City_TMY2.epw"/>
					<city name="Salt Lake City" url="USA_UT_Salt.Lake.City_TMY2.epw"/>
				</state>
				<state name="Virginia">
					<city name="Richmond" url="USA_VA_Richmond_TMY2.epw"/>
					<city name="Roanoke" url="USA_VA_Roanoke_TMY2.epw"/>
				</state>
				<state name="Vermont">
					<city name="Burlington" url="USA_VT_Burlington_TMY2.epw"/>
				</state>
				<state name="Washington">
					<city name="Seattle-Tacoma" url="USA_WA_Seattle-Tacoma_TMY2.epw"/>
					<city name="Spokane" url="USA_WA_Spokane_TMY2.epw"/>
				</state>
				<state name="Wisconsin">
					<city name="Madison" url="USA_WI_Madison_TMY2.epw"/>
					<city name="Milwaukee" url="USA_WI_Milwaukee_TMY2.epw"/>
				</state>
				<state name="West Virginia">
					<city name="Charleston" url="USA_WV_Charleston_TMY2.epw"/>
					<city name="Huntington" url="USA_WV_Huntington_TMY2.epw"/>
				</state>
				<state name="Wyoming">
					<city name="Cheyenne" url="USA_WY_Cheyenne_TMY2.epw"/>
					<city name="Rock Springs" url="USA_WY_Rock.Springs_TMY2.epw"/>
				</state>
			</weatherfiles>
		}
		
		
	}
}

