# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution. The `GadgetsOnline` project compiled without issues under the new cross-platform .NET target.

---

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages that may need updating.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a supported and intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it targets `net8.0` or the appropriate current LTS version of .NET.

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify runtime behavior has not been affected by the migration:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences between the legacy .NET Framework APIs and their cross-platform equivalents.

### 5. Verify Runtime Behavior

Launch the application locally and manually exercise the core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to the following areas that commonly have subtle differences after migration:

- **Database connectivity**: Confirm connection strings are valid and the database provider (e.g., Entity Framework Core) is functioning correctly.
- **Authentication and authorization**: Middleware configuration in cross-platform .NET differs from legacy `System.Web` patterns.
- **Static files and routing**: Verify that routes resolve correctly and static assets are served as expected.
- **Configuration**: Ensure `appsettings.json` contains all values previously held in `Web.config` or `App.config`, as the configuration system has changed.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently at runtime. Review usage of the following if applicable:

- `HttpContext` and related types
- `System.Web` references (these should have been fully removed)
- Any reflection-based code that may depend on assembly structure

### 7. Review NuGet Package Versions

Check for outdated or vulnerable packages:

```bash
dotnet list package --outdated
dotnet list package --vulnerable
```

Update packages as needed using:

```bash
dotnet add package <PackageName> --version <LatestVersion>
```

---

## Deployment

### 1. Publish the Application

Once validation is complete, publish the application for deployment:

```bash
dotnet publish --configuration Release --output ./publish
```

### 2. Verify the Publish Output

Inspect the `./publish` directory to confirm all expected files are present, including static assets, configuration files, and the compiled assemblies.

### 3. Configure the Hosting Environment

Ensure the target server has the correct .NET runtime installed. You can verify the required runtime version from the `<TargetFramework>` in the `.csproj` file and download the appropriate hosting bundle from [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download).

If hosting on IIS, install the **ASP.NET Core Hosting Bundle** and configure the site to use the `AspNetCoreModule` handler in IIS.