package com.posco.hanmadang.common;

public class Constant {
	
	public static String ADMIN_PATH= "/rhksfl/vhtmzh";
	
	public static String INIT 				= "qXt/9Oc+lxDmb72nshvXIQ==";
	public static String DEFAULT_KEY 			= "ANA29hHfdnzPu4KxtTnbTTLASkoDO9suLCfg2kWWQ6M=";
	
	public static String ADMIN_SESSION = "admin_session";
	public static String MEMBER_SESSION = "member_session";
	public static String EMPLOYEE_SESSION = "employee_session";
	public static String TEAM_SESSION = "team_session";
	public static String TEAM_LOGIN_SESSION = "team_login_session";
	public static String LECTURE_SESSION = "lecture_session";
	public static String LECTURE_RESULT_SESSION = "lecture_result_session";
	public static String MEMBER_ID_SESSION = "member_id_session";
	public static String MEMBER_DOR_SESSION = "member_dor_session";
	
	
	public static String ServiceResultJsonValue = "{\"result\" : \"%s\", \"value\" : \"%s\", \"value2\" : \"%s\"}";
	
	public enum ServiceResult {
        SUCCESS, 
        SUCCESS2,
        FAIL,
        FAIL2,
        FAIL3,
        FAIL4,
        DUPLICATE,
        DUPLICATE2,
        NOT_FOUND,
        LEAVE,
        LOCK,
        INVALID_TOKEN,
        NOT_MATCHE,
        INVALID_PARAM,
        INVALID_ACCESS,
        INVALID_ACCESS2,
        BAD_REQUEST,
        UNAUTHORIZED,
        INVALID_TYPE,
        SUCCESS_CHG, // 패스3개월
        SUCCESS_DOR, // 휴면
        PWD_5MLOCK,	// 5분락중
        PWD_LOCK,	// 락처리
    }
	
	public enum YesNoStatus {Y, N, C, D, F};
	
	
	public enum OS_TYPE{
		ios, // iphone
		aos  // android
	}
	
	public enum UploadDirType{
		images,
		editor,
	}
	
	public enum PushType{
		None,
	}
	
	public enum MemberType{
		regular, //정회원
		associate, //준회원
		general, //일반회원
	}
	
	public enum RentingType{
		all(0),		// 전체
		badminton(15), 	//배드민턴
		pingpong(16), 	//탁구
		billiards(17); 	//당구

	    private final int id;
	    RentingType(int id) { this.id = id; }
	    public int getValue() { return id; }
	}
	
	public enum RentReserveType{
		all,
		employee,	// 직원
		team,
		lecture,
		company,
		draw		// 동호회
	}
	
	public enum AdminPath{
		all,		// 전체
		content, 	//컨텐츠 관리
		member, 	//회원관리
		lecture, 	//수강신청
		rent, 		//대관관리
		stats, 		//홈폐이지 분석
		gym, 		//스마트짐 분석
		admin, 		//관리자 관리
	}
	
	public enum EmployeeXLSFile {
        part_name, 
        em_no,
        em_name,
        work_name
    }
	
	public enum ClassXLSFile {
        item_name, 
        class_name,
        class_time,
        em_type,
        o_name,
        ph,
        e_no,
        e_name,
        em_part,
        mem_type,
        gender
    }
	
	public enum VIPXLSFile {
		no,
		name, 
        class_name,
        class_time,
        phone,
        em_name,
        em_type,
        type
    }
	
	public enum ClassUserListMode {
		class_all, // 전체
		class_none, // 미선정
		class_ok, // 선정 및 대기
    }
	
}
