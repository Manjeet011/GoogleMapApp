package com.misha.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "sitterdetails")
public class SitterRegistration {

    @Id
    @Column (name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private String contactname;
    private String email;
    private String password;
    private String companyname;
    private String address;
    private String lat;
    private String lng;
    private String opentime;
    private String closetime;
    private float chargesperhour;
    private String logo;
    private boolean enabled;

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable(
            name = "users_roles",
            joinColumns = @JoinColumn(name = "id"),
            inverseJoinColumns = @JoinColumn(name = "role_id")
    )
    private Set<Role> roles = new HashSet<>();

    public SitterRegistration() {
        super();
    }

    public SitterRegistration(Integer id, String contactname, String email, String password, String companyname,
                              String address, String lat, String lng, String opentime, String closetime, float chargesperhour,
                              String logo, boolean enabled, Set<Role> roles) {
        super();
        this.id = id;
        this.contactname = contactname;
        this.email = email;
        this.password = password;
        this.companyname = companyname;
        this.address = address;
        this.lat = lat;
        this.lng = lng;
        this.opentime = opentime;
        this.closetime = closetime;
        this.chargesperhour = chargesperhour;
        this.logo = logo;
        this.enabled = enabled;
        this.roles = roles;
    }



    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContactname() {
        return contactname;
    }

    public void setContactname(String contactname) {
        this.contactname = contactname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCompanyname() {
        return companyname;
    }

    public void setCompanyname(String companyname) {
        this.companyname = companyname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public String getLng() {
        return lng;
    }

    public void setLng(String lng) {
        this.lng = lng;
    }

    public String getOpentime() {
        return opentime;
    }

    public void setOpentime(String opentime) {
        this.opentime = opentime;
    }

    public String getClosetime() {
        return closetime;
    }

    public void setClosetime(String closetime) {
        this.closetime = closetime;
    }

    public float getChargesperhour() {
        return chargesperhour;
    }

    public void setChargesperhour(float chargesperhour) {
        this.chargesperhour = chargesperhour;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

}
