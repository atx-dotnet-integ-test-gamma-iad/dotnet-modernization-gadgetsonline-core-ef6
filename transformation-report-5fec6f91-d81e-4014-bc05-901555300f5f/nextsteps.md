# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate latent issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET, such as `net8.0`. Avoid `net5.0` or `net6.0` if long-term support is a requirement.

```xml
<TargetFramework>net8.0</TargetFramework>
```

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and verify that all pages, routes, and features behave as expected compared to the legacy version.

### 5. Check for Runtime Errors

Even with a clean build, runtime issues can exist. Pay particular attention to:

- **Database connectivity**: Confirm connection strings in `appsettings.json` are correct and that any Entity Framework migrations are up to date. Run `dotnet ef database update` if applicable.
- **Static files**: Verify that CSS, JavaScript, and image assets are being served correctly.
- **Authentication/Authorization**: If the project uses any authentication middleware, confirm it has been correctly configured for the new hosting model.
- **Session and cookies**: Behavior may differ from the legacy ASP.NET pipeline.

### 6. Check for Removed or Changed APIs

Review any usages of APIs that were available in the .NET Framework but have changed or been removed in cross-platform .NET. Common areas include:

- `System.Web` namespace (not available in .NET Core and later)
- `HttpContext` access patterns
- `ConfigurationManager` (replaced by `IConfiguration`)
- `Global.asax` logic (should be moved to `Program.cs` or `Startup.cs`)

### 7. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they indicate a regression introduced during migration or a test that requires updating to reflect the new project structure.

### 8. Review Logging and Error Handling

Confirm that logging is properly configured in `Program.cs` using the `Microsoft.Extensions.Logging` infrastructure. Ensure unhandled exceptions are surfaced appropriately during local testing.

### 9. Validate Configuration Files

Ensure that `appsettings.json` and `appsettings.Development.json` contain all necessary configuration values that were previously stored in `Web.config` or `App.config`. The `Web.config` file is no longer the primary configuration source in cross-platform .NET.