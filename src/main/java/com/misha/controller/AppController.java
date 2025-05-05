package com.misha.controller;


import com.misha.model.SitterRegistration;
import com.misha.service.RegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.Page;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class AppController {


    @Autowired
    private RegistrationService registrationService;

    @GetMapping(value = {"/","/home"})
    public String getWelcomePage()
    {
        return "welcome";
    }


    @GetMapping("/register")
    public String dogSitterRegistration(HttpServletRequest request) {
        request.setAttribute("mode", "MODE_REGISTER");
        return "sitterRegistration";

    }

    @GetMapping("/search")
    public String searchingDogsitter(HttpServletRequest request) {
        request.setAttribute("mode", "MODE_REGISTER");
        return "searchDogSitterPage";

    }

    @GetMapping("/totalrecords")
    public String getTotalRecords(HttpServletRequest request) {
        request.setAttribute("mode", "MODE_REGISTER");
        return "sitterRecords";

    }

    @PostMapping("/saveDetails")
    public String saveSitterDetails(@ModelAttribute SitterRegistration sitter, @RequestParam("logopart") MultipartFile file, HttpServletRequest request)
    {

          System.out.println(file);
        // Get the real path to `webapp/images`
        String uploadDir = request.getServletContext().getRealPath("/images/");
        String fileName = file.getOriginalFilename();

        try {
            // Ensure the directory exists
            Path uploadPath = Paths.get(uploadDir);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Save the file
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            // Set the filename in the Registration object
            sitter.setLogo(fileName);
        } catch (IOException e) {
            e.printStackTrace();
            return ""; // Handle error case
        }

        sitter.setLogo(fileName);
        registrationService.saveSitterDetails(sitter);
        return "welcome";
    }


    @PostMapping("/loginservlet")
    public String getSitterDetailsUsingEmailPassword(@RequestParam("email") String email,@RequestParam("password") String password) {


        System.out.println(email);
        System.out.println(password);
        SitterRegistration registration=registrationService.fetchByEmailAndPassword(email,password);

        System.out.println("Name of Comapany Bro"+registration.getCompanyname()+"Name"+registration.getContactname());
        if(registration==null)
        {
            return "login";
        }

        return "welcome";

    }


    @GetMapping ("/searchOperation")
    public String searchSitter(@RequestParam("location") String location,@RequestParam("latitude") String latitude,@RequestParam("longitude") String longitude,HttpServletRequest request) {

        System.out.println(location);
        System.out.println(longitude);
        System.out.println(latitude);
        String searchAddress = "%" +location+ "%";
        List<SitterRegistration> list=registrationService.findAlllUserNearThisLoccation(latitude,longitude);
        request.setAttribute("sitters",list);
        request.setAttribute("address", location);
        request.setAttribute("latitude", latitude);
        request.setAttribute("longitude", longitude);
        System.out.println(list.size());
        System.out.println("Hello");
        return "searchDogSitterPage";

    }


    @GetMapping("/admin/showRecords/**")
    public String getAllSitterRecords(@RequestParam(defaultValue = "1") int page,HttpServletRequest request) {

        int page1=1;

        if(page!=0)
        {
             page1=page-1;
        }

        System.out.println(page1);
        int size1=5;

        Page<SitterRegistration> list= registrationService.fetchAllDetails(size1,page1);
        request.setAttribute("sittersrecords",list.getContent());
        request.setAttribute("totalrecords",(int)list.getTotalPages());
        request.setAttribute("currentpage",(int)page1);
        System.out.println(list.getContent().size());



        return "sitterRecords";

    }

    @GetMapping("/profile")
    public String getProfile(HttpServletRequest request , @AuthenticationPrincipal UserDetails user) {


        System.out.println("username"+user.getPassword());
        System.out.println(user.getUsername());




        request.setAttribute("loggedInUser", user);
        return "profile";
    }

    @PostMapping("/updateProfile")
    public  String updateUserPassword(  @RequestParam String email,
                                        @RequestParam String newPassword,
                                        HttpServletRequest request)
    {

        SitterRegistration sitterregistration= registrationService.getUserByEmail(email);
        sitterregistration.setPassword(newPassword);
        registrationService.updateSitterDetails(sitterregistration);
        return  "welcome";
    }

}
